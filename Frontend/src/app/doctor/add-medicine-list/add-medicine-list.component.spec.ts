import { ComponentFixture, TestBed } from '@angular/core/testing';

import { AddMedicineListComponent } from './add-medicine-list.component';

describe('AddMedicineListComponent', () => {
  let component: AddMedicineListComponent;
  let fixture: ComponentFixture<AddMedicineListComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ AddMedicineListComponent ]
    })
    .compileComponents();

    fixture = TestBed.createComponent(AddMedicineListComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
