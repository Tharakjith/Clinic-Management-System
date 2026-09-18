import { ComponentFixture, TestBed } from '@angular/core/testing';

import { LabtechniciandashComponent } from './labtechniciandash.component';

describe('LabtechniciandashComponent', () => {
  let component: LabtechniciandashComponent;
  let fixture: ComponentFixture<LabtechniciandashComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ LabtechniciandashComponent ]
    })
    .compileComponents();

    fixture = TestBed.createComponent(LabtechniciandashComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
