import { ComponentFixture, TestBed } from '@angular/core/testing';

import { AppointmentsBookatComponent } from './appointments-bookat.component';

describe('AppointmentsBookatComponent', () => {
  let component: AppointmentsBookatComponent;
  let fixture: ComponentFixture<AppointmentsBookatComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ AppointmentsBookatComponent ]
    })
    .compileComponents();

    fixture = TestBed.createComponent(AppointmentsBookatComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
