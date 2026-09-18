import { TestBed } from '@angular/core/testing';

import { MedicinebillService } from './medicinebill.service';

describe('MedicinebillService', () => {
  let service: MedicinebillService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(MedicinebillService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
