import { ComponentFixture, TestBed } from '@angular/core/testing';

import { AddMedicineEditComponent } from './add-medicine-edit.component';

describe('AddMedicineEditComponent', () => {
  let component: AddMedicineEditComponent;
  let fixture: ComponentFixture<AddMedicineEditComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ AddMedicineEditComponent ]
    })
    .compileComponents();

    fixture = TestBed.createComponent(AddMedicineEditComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
