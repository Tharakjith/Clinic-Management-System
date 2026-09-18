import { TestBed } from '@angular/core/testing';

import { DmanagementService } from './dmanagement.service';

describe('DmanagementService', () => {
  let service: DmanagementService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(DmanagementService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
