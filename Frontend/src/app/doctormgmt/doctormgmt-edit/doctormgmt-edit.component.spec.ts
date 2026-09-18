import { ComponentFixture, TestBed } from '@angular/core/testing';

import { DoctormgmtEditComponent } from './doctormgmt-edit.component';

describe('DoctormgmtEditComponent', () => {
  let component: DoctormgmtEditComponent;
  let fixture: ComponentFixture<DoctormgmtEditComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ DoctormgmtEditComponent ]
    })
    .compileComponents();

    fixture = TestBed.createComponent(DoctormgmtEditComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
