import { ComponentFixture, TestBed } from '@angular/core/testing';

import { RechargepageComponent } from './rechargepage.component';

describe('RechargepageComponent', () => {
  let component: RechargepageComponent;
  let fixture: ComponentFixture<RechargepageComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ RechargepageComponent ]
    })
    .compileComponents();

    fixture = TestBed.createComponent(RechargepageComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
