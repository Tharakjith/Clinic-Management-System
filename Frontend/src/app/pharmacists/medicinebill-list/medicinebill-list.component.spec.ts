import { ComponentFixture, TestBed } from '@angular/core/testing';

import { MedicinebillListComponent } from './medicinebill-list.component';

describe('MedicinebillListComponent', () => {
  let component: MedicinebillListComponent;
  let fixture: ComponentFixture<MedicinebillListComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ MedicinebillListComponent ]
    })
    .compileComponents();

    fixture = TestBed.createComponent(MedicinebillListComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
