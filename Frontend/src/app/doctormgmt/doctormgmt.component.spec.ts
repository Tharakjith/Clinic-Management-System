import { ComponentFixture, TestBed } from '@angular/core/testing';

import { DoctormgmtComponent } from './doctormgmt.component';

describe('DoctormgmtComponent', () => {
  let component: DoctormgmtComponent;
  let fixture: ComponentFixture<DoctormgmtComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ DoctormgmtComponent ]
    })
    .compileComponents();

    fixture = TestBed.createComponent(DoctormgmtComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
