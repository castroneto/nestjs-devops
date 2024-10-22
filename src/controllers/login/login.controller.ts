import { Controller, Get, Post, Render } from '@nestjs/common';

@Controller()
export class LoginController {
    @Get()
    @Render('index')
    index() {
        return { title: 'Minha página com componentes!' };
    }

    @Post('login')
    login() {
        return { title: 'Minha página com componentes!' };
    }
}
