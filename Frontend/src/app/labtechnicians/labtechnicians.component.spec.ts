import { ComponentFixture, TestBed } from '@angular/core/testing';

import { LabtechniciansComponent } from './labtechnicians.component';

describe('LabtechniciansComponent', () => {
  let component: LabtechniciansComponent;
  let fixture: ComponentFixture<LabtechniciansComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ LabtechniciansComponent ]
    })
    .compileComponents();

    fixture = TestBed.createComponent(LabtechniciansComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
