import { Controller, Get } from '@nestjs/common';

@Controller()
export class MainController {

    @Get()
    hello(): string {
        return "server bitshopp on"
    }
}
