import { ComponentFixture, TestBed } from '@angular/core/testing';

import { PharmacistdashComponent } from './pharmacistdash.component';

describe('PharmacistdashComponent', () => {
  let component: PharmacistdashComponent;
  let fixture: ComponentFixture<PharmacistdashComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ PharmacistdashComponent ]
    })
    .compileComponents();

    fixture = TestBed.createComponent(PharmacistdashComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
