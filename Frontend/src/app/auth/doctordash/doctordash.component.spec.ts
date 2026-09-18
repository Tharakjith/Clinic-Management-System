import { ComponentFixture, TestBed } from '@angular/core/testing';

import { DoctordashComponent } from './doctordash.component';

describe('DoctordashComponent', () => {
  let component: DoctordashComponent;
  let fixture: ComponentFixture<DoctordashComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ DoctordashComponent ]
    })
    .compileComponents();

    fixture = TestBed.createComponent(DoctordashComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
