import { Body, Controller, Param, Post } from '@nestjs/common';

@Controller('calls')
export class CallsController {
  @Post()
  start(@Body() body: { conversationId: string; video?: boolean; group?: boolean; screen?: boolean }) {
    return {
      id: crypto.randomUUID(),
      e2ee: true,
      aiSummaryEnabled: true,
      ...body,
      status: 'started',
    };
  }

  @Post(':id/summary')
  summarize(@Param('id') id: string) {
    return {
      callId: id,
      summary: 'تم تلخيص المكالمة: قرارات، مهام، ونقاط متابعة.',
    };
  }
}
