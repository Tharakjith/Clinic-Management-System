import { ComponentFixture, TestBed } from '@angular/core/testing';

import { StartDiagnosysAddComponent } from './start-diagnosys-add.component';

describe('StartDiagnosysAddComponent', () => {
  let component: StartDiagnosysAddComponent;
  let fixture: ComponentFixture<StartDiagnosysAddComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ StartDiagnosysAddComponent ]
    })
    .compileComponents();

    fixture = TestBed.createComponent(StartDiagnosysAddComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
