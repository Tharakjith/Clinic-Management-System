import { ComponentFixture, TestBed } from '@angular/core/testing';

import { StartDiagnosysEditComponent } from './start-diagnosys-edit.component';

describe('StartDiagnosysEditComponent', () => {
  let component: StartDiagnosysEditComponent;
  let fixture: ComponentFixture<StartDiagnosysEditComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ StartDiagnosysEditComponent ]
    })
    .compileComponents();

    fixture = TestBed.createComponent(StartDiagnosysEditComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
