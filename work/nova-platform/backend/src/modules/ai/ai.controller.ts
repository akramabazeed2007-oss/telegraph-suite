import { Body, Controller, Post } from '@nestjs/common';

@Controller('ai')
export class AiController {
  @Post('summarize')
  summarize(@Body() body: { scope: string; text: string }) {
    return {
      scope: body.scope,
      summary: 'ملخص Nova AI: أهم النقاط، القرارات، والمهام التالية.',
    };
  }

  @Post('translate')
  translate(@Body() body: { text: string; targetLanguage: string }) {
    return {
      source: body.text,
      targetLanguage: body.targetLanguage,
      translated: `[${body.targetLanguage}] ${body.text}`,
    };
  }
}
