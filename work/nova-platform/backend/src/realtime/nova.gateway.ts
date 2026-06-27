import {
  ConnectedSocket,
  MessageBody,
  SubscribeMessage,
  WebSocketGateway,
  WebSocketServer,
} from '@nestjs/websockets';
import { Server, Socket } from 'socket.io';

@WebSocketGateway({
  cors: { origin: true, credentials: true },
  namespace: '/nova',
})
export class NovaGateway {
  @WebSocketServer()
  server!: Server;

  @SubscribeMessage('conversation.join')
  joinConversation(
    @ConnectedSocket() client: Socket,
    @MessageBody() body: { conversationId: string },
  ) {
    client.join(`conversation:${body.conversationId}`);
    return { ok: true };
  }

  @SubscribeMessage('message.send')
  sendMessage(
    @ConnectedSocket() client: Socket,
    @MessageBody() body: { conversationId: string; text: string },
  ) {
    this.server
      .to(`conversation:${body.conversationId}`)
      .emit('message.created', {
        id: crypto.randomUUID(),
        conversationId: body.conversationId,
        text: body.text,
        sentAt: new Date().toISOString(),
      });
    return { ok: true };
  }

  @SubscribeMessage('presence.typing')
  typing(@MessageBody() body: { conversationId: string; userId: string }) {
    this.server
      .to(`conversation:${body.conversationId}`)
      .emit('presence.typing', body);
    return { ok: true };
  }
}
