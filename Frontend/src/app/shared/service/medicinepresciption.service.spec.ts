import { TestBed } from '@angular/core/testing';

import { MedicinepresciptionService } from './medicinepresciption.service';

describe('MedicinepresciptionService', () => {
  let service: MedicinepresciptionService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(MedicinepresciptionService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
