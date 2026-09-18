import { ComponentFixture, TestBed } from '@angular/core/testing';

import { StartDiagnosysListComponent } from './start-diagnosys-list.component';

describe('StartDiagnosysListComponent', () => {
  let component: StartDiagnosysListComponent;
  let fixture: ComponentFixture<StartDiagnosysListComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ StartDiagnosysListComponent ]
    })
    .compileComponents();

    fixture = TestBed.createComponent(StartDiagnosysListComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
