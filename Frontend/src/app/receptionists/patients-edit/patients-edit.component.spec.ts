import { ComponentFixture, TestBed } from '@angular/core/testing';

import { PatientsEditComponent } from './patients-edit.component';

describe('PatientsEditComponent', () => {
  let component: PatientsEditComponent;
  let fixture: ComponentFixture<PatientsEditComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ PatientsEditComponent ]
    })
    .compileComponents();

    fixture = TestBed.createComponent(PatientsEditComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
