import { ComponentFixture, TestBed } from '@angular/core/testing';

import { DoctormgmtAddComponent } from './doctormgmt-add.component';

describe('DoctormgmtAddComponent', () => {
  let component: DoctormgmtAddComponent;
  let fixture: ComponentFixture<DoctormgmtAddComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ DoctormgmtAddComponent ]
    })
    .compileComponents();

    fixture = TestBed.createComponent(DoctormgmtAddComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
