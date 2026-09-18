import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ReceptionistdashComponent } from './receptionistdash.component';

describe('ReceptionistdashComponent', () => {
  let component: ReceptionistdashComponent;
  let fixture: ComponentFixture<ReceptionistdashComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ ReceptionistdashComponent ]
    })
    .compileComponents();

    fixture = TestBed.createComponent(ReceptionistdashComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
