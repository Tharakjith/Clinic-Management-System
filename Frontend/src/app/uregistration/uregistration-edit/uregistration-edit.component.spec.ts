import { ComponentFixture, TestBed } from '@angular/core/testing';

import { UregistrationEditComponent } from './uregistration-edit.component';

describe('UregistrationEditComponent', () => {
  let component: UregistrationEditComponent;
  let fixture: ComponentFixture<UregistrationEditComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ UregistrationEditComponent ]
    })
    .compileComponents();

    fixture = TestBed.createComponent(UregistrationEditComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
