import { ComponentFixture, TestBed } from '@angular/core/testing';

import { PharmacistsComponent } from './pharmacists.component';

describe('PharmacistsComponent', () => {
  let component: PharmacistsComponent;
  let fixture: ComponentFixture<PharmacistsComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ PharmacistsComponent ]
    })
    .compileComponents();

    fixture = TestBed.createComponent(PharmacistsComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
