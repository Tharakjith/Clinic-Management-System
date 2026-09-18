import { ComponentFixture, TestBed } from '@angular/core/testing';

import { LabtestaddEditComponent } from './labtestadd-edit.component';

describe('LabtestaddEditComponent', () => {
  let component: LabtestaddEditComponent;
  let fixture: ComponentFixture<LabtestaddEditComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ LabtestaddEditComponent ]
    })
    .compileComponents();

    fixture = TestBed.createComponent(LabtestaddEditComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
