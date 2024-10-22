import { Test, TestingModule } from '@nestjs/testing';
import { DasbhoardController } from './dasbhoard.controller';

describe('DasbhoardController', () => {
  let controller: DasbhoardController;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      controllers: [DasbhoardController],
    }).compile();

    controller = module.get<DasbhoardController>(DasbhoardController);
  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
  });
});
