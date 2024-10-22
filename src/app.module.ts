import { Module } from '@nestjs/common';
import { LoginController } from './controllers/login/login.controller';
import { DasbhoardController } from './controllers/dasbhoard/dasbhoard.controller';
@Module({
  imports: [],
  controllers: [LoginController, DasbhoardController],
  providers: [],
})
export class AppModule {}
