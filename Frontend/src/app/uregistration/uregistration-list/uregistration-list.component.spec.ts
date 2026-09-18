import { ComponentFixture, TestBed } from '@angular/core/testing';

import { UregistrationListComponent } from './uregistration-list.component';

describe('UregistrationListComponent', () => {
  let component: UregistrationListComponent;
  let fixture: ComponentFixture<UregistrationListComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ UregistrationListComponent ]
    })
    .compileComponents();

    fixture = TestBed.createComponent(UregistrationListComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
