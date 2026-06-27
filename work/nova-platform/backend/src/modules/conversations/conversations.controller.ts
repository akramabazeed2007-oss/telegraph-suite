import { Body, Controller, Get, Param, Post } from '@nestjs/common';
import { ConversationsService } from './conversations.service';

@Controller('conversations')
export class ConversationsController {
  constructor(private readonly conversations: ConversationsService) {}

  @Get()
  list() {
    return this.conversations.list();
  }

  @Post()
  create(@Body() body: { type: string; title: string }) {
    return this.conversations.create(body);
  }

  @Get(':id/messages')
  messages(@Param('id') id: string) {
    return this.conversations.messages(id);
  }

  @Post(':id/messages')
  send(@Param('id') id: string, @Body() body: { text: string; scheduledFor?: string }) {
    return this.conversations.send(id, body);
  }
}
