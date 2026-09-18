import { ComponentFixture, TestBed } from '@angular/core/testing';

import { UregistrationAddComponent } from './uregistration-add.component';

describe('UregistrationAddComponent', () => {
  let component: UregistrationAddComponent;
  let fixture: ComponentFixture<UregistrationAddComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ UregistrationAddComponent ]
    })
    .compileComponents();

    fixture = TestBed.createComponent(UregistrationAddComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
