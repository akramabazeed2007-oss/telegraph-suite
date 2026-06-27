import { Injectable } from '@nestjs/common';

@Injectable()
export class ConversationsService {
  private readonly conversations = [
    { id: 'direct-demo', type: 'direct', title: 'مريم النور' },
    { id: 'group-demo', type: 'group', title: 'فريق المنتج' },
    { id: 'channel-demo', type: 'channel', title: 'قناة Nova' },
  ];

  list() {
    return this.conversations;
  }

  create(body: { type: string; title: string }) {
    const conversation = { id: crypto.randomUUID(), ...body };
    this.conversations.unshift(conversation);
    return conversation;
  }

  messages(id: string) {
    return [
      { id: crypto.randomUUID(), conversationId: id, sender: 'system', text: 'Nova conversation ready.' },
    ];
  }

  send(id: string, body: { text: string; scheduledFor?: string }) {
    return {
      id: crypto.randomUUID(),
      conversationId: id,
      text: body.text,
      scheduledFor: body.scheduledFor,
      status: body.scheduledFor ? 'scheduled' : 'sent',
    };
  }
}
