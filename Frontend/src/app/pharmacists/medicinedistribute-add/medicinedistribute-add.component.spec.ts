import { ComponentFixture, TestBed } from '@angular/core/testing';

import { MedicinedistributeAddComponent } from './medicinedistribute-add.component';

describe('MedicinedistributeAddComponent', () => {
  let component: MedicinedistributeAddComponent;
  let fixture: ComponentFixture<MedicinedistributeAddComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ MedicinedistributeAddComponent ]
    })
    .compileComponents();

    fixture = TestBed.createComponent(MedicinedistributeAddComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
