import { TestBed } from '@angular/core/testing';

import { LabtestpresService } from './labtestpres.service';

describe('LabtestpresService', () => {
  let service: LabtestpresService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(LabtestpresService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
