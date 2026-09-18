import { ComponentFixture, TestBed } from '@angular/core/testing';

import { MedicineManagementsComponent } from './medicine-managements.component';

describe('MedicineManagementsComponent', () => {
  let component: MedicineManagementsComponent;
  let fixture: ComponentFixture<MedicineManagementsComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ MedicineManagementsComponent ]
    })
    .compileComponents();

    fixture = TestBed.createComponent(MedicineManagementsComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
