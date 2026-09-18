import { ComponentFixture, TestBed } from '@angular/core/testing';

import { AddMedicineAddComponent } from './add-medicine-add.component';

describe('AddMedicineAddComponent', () => {
  let component: AddMedicineAddComponent;
  let fixture: ComponentFixture<AddMedicineAddComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ AddMedicineAddComponent ]
    })
    .compileComponents();

    fixture = TestBed.createComponent(AddMedicineAddComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
