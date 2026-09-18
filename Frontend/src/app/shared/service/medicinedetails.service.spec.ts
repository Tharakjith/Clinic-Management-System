import { TestBed } from '@angular/core/testing';

import { MedicinedetailsService } from './medicinedetails.service';

describe('MedicinedetailsService', () => {
  let service: MedicinedetailsService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(MedicinedetailsService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
