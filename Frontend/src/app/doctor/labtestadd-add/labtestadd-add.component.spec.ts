import { ComponentFixture, TestBed } from '@angular/core/testing';

import { LabtestaddAddComponent } from './labtestadd-add.component';

describe('LabtestaddAddComponent', () => {
  let component: LabtestaddAddComponent;
  let fixture: ComponentFixture<LabtestaddAddComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ LabtestaddAddComponent ]
    })
    .compileComponents();

    fixture = TestBed.createComponent(LabtestaddAddComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
