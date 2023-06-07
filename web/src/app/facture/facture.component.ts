import { Component } from '@angular/core';

@Component({
  selector: 'app-facture',
  templateUrl: './facture.component.html',
  styleUrls: ['./facture.component.scss']
})
export class FactureComponent {

  facturations = [
    { 
      montant: 500+' DH',  
      nom: "Facture 001",
      image:"../../assets/radeema.png",
      description: "description ............"
    },
    { 
      montant: 1000+' DH', 
      nom: "Facture 002",
      image:"../../assets/radeef.jpg",
      description: "description ............"
    },
    {
       montant: 1400+' DH',
       nom: "Facture 003", 
       image:"../../assets/radeef.jpg",
       description: "description ............"
    },
    {
      montant: 200+' DH',
      nom: "Facture 004", 
      image:"../../assets/radeema.png",
      description: "description ............"
   },
       
  ];

    

}
