import { Controller, Get } from '@nestjs/common';

@Controller('admin')
export class AdminController {
  @Get('dashboard')
  dashboard() {
    return {
      users: 2400000,
      openReports: 318,
      starTransactionsToday: 94000,
      premiumGrowth: '18%',
    };
  }

  @Get('reports')
  reports() {
    return [
      { id: 'report-1', targetType: 'clip', status: 'open', reason: 'spam' },
      { id: 'report-2', targetType: 'channel', status: 'reviewing', reason: 'abuse' },
    ];
  }
}
