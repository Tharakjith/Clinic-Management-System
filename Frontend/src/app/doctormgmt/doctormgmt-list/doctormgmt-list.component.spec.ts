import { ComponentFixture, TestBed } from '@angular/core/testing';

import { DoctormgmtListComponent } from './doctormgmt-list.component';

describe('DoctormgmtListComponent', () => {
  let component: DoctormgmtListComponent;
  let fixture: ComponentFixture<DoctormgmtListComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ DoctormgmtListComponent ]
    })
    .compileComponents();

    fixture = TestBed.createComponent(DoctormgmtListComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
