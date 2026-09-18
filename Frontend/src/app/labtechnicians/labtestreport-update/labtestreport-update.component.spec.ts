import { ComponentFixture, TestBed } from '@angular/core/testing';

import { LabtestreportUpdateComponent } from './labtestreport-update.component';

describe('LabtestreportUpdateComponent', () => {
  let component: LabtestreportUpdateComponent;
  let fixture: ComponentFixture<LabtestreportUpdateComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ LabtestreportUpdateComponent ]
    })
    .compileComponents();

    fixture = TestBed.createComponent(LabtestreportUpdateComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
