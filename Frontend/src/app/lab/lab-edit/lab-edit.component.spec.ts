import { ComponentFixture, TestBed } from '@angular/core/testing';

import { LabEditComponent } from './lab-edit.component';

describe('LabEditComponent', () => {
  let component: LabEditComponent;
  let fixture: ComponentFixture<LabEditComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ LabEditComponent ]
    })
    .compileComponents();

    fixture = TestBed.createComponent(LabEditComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
