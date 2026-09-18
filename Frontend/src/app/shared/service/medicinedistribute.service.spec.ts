import { TestBed } from '@angular/core/testing';

import { MedicinedistributeService } from './medicinedistribute.service';

describe('MedicinedistributeService', () => {
  let service: MedicinedistributeService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(MedicinedistributeService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
