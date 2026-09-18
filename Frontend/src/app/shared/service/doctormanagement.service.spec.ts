import { TestBed } from '@angular/core/testing';

import { DoctormanagementService } from './doctormanagement.service';

describe('DoctormanagementService', () => {
  let service: DoctormanagementService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(DoctormanagementService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
