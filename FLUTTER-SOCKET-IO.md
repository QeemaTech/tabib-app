# Flutter Chat Integration — Socket.IO

هذا الملف مخصص لمطور Flutter لربط الشات مع Tabeeb API.

## 1. بيانات الاتصال

```text
API Base URL:  https://tabeeb.nodeteam.site/api/v1
Socket URL:    https://tabeeb.nodeteam.site
Socket path:   /socket.io
```

مهم:

- لا تضف `/api/v1` إلى `Socket URL`.
- لا تضف `:0` أو أي Port في رابط HTTPS.
- لا تستخدم Socket.IO للصوت أو الفيديو. المكالمات تستخدم Agora RTC.
- **نفس الاتصال** يستقبل إشعارات in-app: `notification:new` — راجع [FLUTTER-NOTIFICATIONS.md](./FLUTTER-NOTIFICATIONS.md).
- أحداث `chat:*` للشات؛ `call:*` اختياري للمكالمة (الوسائط عبر Agora).

## 2. تثبيت الحزمة

```yaml
dependencies:
  socket_io_client: ^2.0.3+1
```

## 3. إنشاء الاتصال

يتم الحصول على `accessToken` من تسجيل الدخول ثم إرساله في `auth`.

```dart
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatSocket {
  late final IO.Socket socket;

  void connect(String accessToken) {
    socket = IO.io(
      'https://tabeeb.nodeteam.site',
      IO.OptionBuilder()
          .setPath('/socket.io')
          .setTransports(['polling', 'websocket'])
          .setAuth({'token': accessToken})
          .enableAutoConnect()
          .enableForceNew()
          .build(),
    );

    socket.onConnect((_) {
      print('Socket connected: ${socket.id}');
    });

    socket.onDisconnect((reason) {
      print('Socket disconnected: $reason');
    });

    socket.onConnectError((error) {
      print('Socket connection error: $error');
    });

    socket.onError((error) {
      print('Socket error: $error');
    });
  }
}
```

لا تستخدم:

```dart
.setPort(0)
.setTransports(['websocket'])
```

استخدام `polling` مع `websocket` يسمح بالاتصال حتى لو كان الـ reverse proxy لا يسمح بترقية WebSocket في لحظة معينة.

## 4. دورة حياة الاتصال

### عند فتح شاشة التطبيق

1. تأكد من وجود `accessToken`.
2. أنشئ Socket واحدًا فقط لكل جلسة مستخدم.
3. اتصل بالسيرفر.
4. بعد `connect` أرسل `chat:join` للمحادثة المفتوحة.

### عند إعادة الاتصال

بعد `connect` مرة أخرى يجب إعادة إرسال:

```dart
socket.emit('chat:join', {
  'consultationId': consultationId,
});
```

الغرفة لا تستمر تلقائيًا بعد انقطاع الاتصال.

### عند تسجيل الخروج

```dart
socket.dispose();
```

لا تنشئ Socket جديدًا عند كل rebuild للـ Widget.

## 5. الحصول على المحادثة وبدء Chat

`consultationId` ليس هو `appointmentId`.

### جلب المحادثات

```http
GET /consultations
Authorization: Bearer {accessToken}
```

### بدء محادثة الحجز

يجب أن يكون الحجز:

- `CONFIRMED` أو `IN_PROGRESS`
- مدفوعًا
- داخل وقت إتاحة الشات

```http
POST /consultations/{appointmentId}/start
Authorization: Bearer {accessToken}
Content-Type: application/json
```

```json
{
  "type": "CHAT"
}
```

استخدم `data.id` من الاستجابة كـ `consultationId`.

## 6. دخول غرفة المحادثة

```dart
socket.emit('chat:join', {
  'consultationId': consultationId,
});

socket.once('chat:joined', (data) {
  print('Joined room: ${data['roomId']}');
});

socket.once('chat:error', (error) {
  print('Cannot join chat: $error');
});
```

الاستجابة:

```json
{
  "consultationId": "consultation-uuid",
  "roomId": "chat-room-uuid"
}
```

## 7. إرسال واستقبال رسالة

### إرسال رسالة نصية

```dart
socket.emit('chat:message', {
  'consultationId': consultationId,
  'content': 'مرحبًا دكتور',
});
```

### تأكيد حفظ الرسالة للمرسل

```dart
socket.on('chat:sent', (message) {
  // أضف الرسالة إلى القائمة أو حدّث الرسالة المؤقتة.
  print('Saved message: ${message['id']}');
});
```

### استقبال رسالة من الطرف الآخر

```dart
socket.on('chat:message', (message) {
  // اعرض الرسالة إذا لم تكن موجودة مسبقًا.
  print('Incoming message: ${message['content']}');
});
```

لا تضف نفس الرسالة مرتين: الرسالة التي يرسلها المستخدم تصل له عبر `chat:sent`، أما `chat:message` فهي للطرف الآخر.

### رسالة بها ملف

ارفع الملف أولًا باستخدام Upload API، ثم أرسل رابط الملف:

```dart
socket.emit('chat:message', {
  'consultationId': consultationId,
  'content': 'التقرير مرفق',
  'fileUrl': 'https://...',
  'fileType': 'FILE', // IMAGE أو FILE
  'fileName': 'report.pdf',
  'fileSize': 102400,
});
```

## 8. حالة الكتابة Typing

```dart
socket.emit('chat:typing', {
  'consultationId': consultationId,
  'isTyping': true,
});
```

```dart
socket.on('chat:typing', (data) {
  final isTyping = data['isTyping'] == true;
  // اعرض أو أخفِ "يكتب الآن".
});
```

أرسل `isTyping: false` عند توقف المستخدم، ويفضل استخدام debounce بدل الإرسال مع كل حرف.

## 9. قراءة الرسائل

### قراءة رسالة واحدة

```dart
socket.emit('chat:read', {
  'consultationId': consultationId,
  'messageId': messageId,
});
```

### قراءة كل الرسائل

```dart
socket.emit('chat:readAll', {
  'consultationId': consultationId,
});
```

استمع إلى:

```dart
socket.on('chat:read', (data) {
  // حدّث isRead و readAt للرسالة.
});

socket.on('chat:readAll', (data) {
  // حدّث كل الرسائل غير المقروءة.
});
```

## 10. Delivered وStatus

عند وصول الرسالة للطرف الآخر يستقبل:

```dart
socket.on('chat:delivered', (data) {
  final messageId = data['messageId'];
  // حدّث حالة الرسالة إلى DELIVERED.
});
```

الـ backend يرسل `chat:delivered` بعد حفظ الرسالة بنجاح.

## 11. أخطاء شائعة

```dart
socket.on('chat:error', (error) {
  final code = error['code'];
  final message = error['message'];
});
```

الأسباب الأكثر شيوعًا:

- `UNAUTHORIZED`: التوكن غير صحيح أو منتهي.
- `FORBIDDEN`: المستخدم ليس طرفًا في المحادثة.
- `NOT_FOUND`: `consultationId` غير موجود.
- `INVALID_STATUS`: المحادثة غير نشطة أو الحجز خارج وقت الشات.

عند `UNAUTHORIZED` نفّذ refresh للتوكن ثم أعد إنشاء الاتصال. لا ترسل توكن `refreshToken` إلى Socket؛ استخدم `accessToken` فقط.

## 12. REST Fallback

إذا انقطع Socket أو فشل الاتصال، استخدم REST:

```http
POST /consultations/{consultationId}/messages
GET  /consultations/{consultationId}/messages?limit=30
```

لجلب الصفحة الأقدم:

```http
GET /consultations/{consultationId}/messages?limit=30&before={meta.nextBefore}
```

لا تعتمد على Socket وحده لحفظ الرسائل؛ REST هو fallback الرسمي.

## 13. Checklist قبل التسليم

- [ ] الاتصال باستخدام `https://tabeeb.nodeteam.site` بدون Port.
- [ ] `path` مضبوط على `/socket.io`.
- [ ] التوكن داخل `auth.token`.
- [ ] استخدام `polling` و`websocket`.
- [ ] إرسال `chat:join` بعد كل اتصال أو reconnect.
- [ ] استخدام `consultationId` وليس `appointmentId` في Events.
- [ ] منع تكرار الرسائل في واجهة المستخدم.
- [ ] وجود REST fallback.
- [ ] Socket للشات فقط، وAgora للصوت والفيديو.

تم اختبار السيرفر بنجاح باختبار تكاملي يغطي الاتصال والمصادقة وJoin وTyping والرسائل وDelivered وRead وReadAll وReconnect.
