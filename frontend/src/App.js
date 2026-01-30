import { Routes, Route } from 'react-router-dom';
import './App.css';
import Home from './pages/Home';
import Airlines from './pages/Airlines';
import Flights from './pages/Flights';
import Navigation from './components/Navigation';

import { getWebInstrumentations, initializeFaro } from '@grafana/faro-web-sdk';
import { TracingInstrumentation } from '@grafana/faro-web-tracing';

initializeFaro({
  url: 'https://faro-collector-prod-us-west-0.grafana.net/collect/25cd360d654c763b4ba2e415d3e802c1',
  app: {
    name: 'airlines-ui',
    version: '1.0.0',
    environment: 'production'
  },
  
  instrumentations: [
    // Mandatory, omits default instrumentations otherwise.
    ...getWebInstrumentations(),

    // Tracing package to get end-to-end visibility for HTTP requests.
    new TracingInstrumentation(),
  ],
});

function App() {
  return (
    <div className="App">
      <header className="App-header">
        <Navigation />
        <Routes>
          <Route path="/" element={<Home />} />
          <Route path="/flights" element={<Flights />} />
          <Route path="/airlines" element={<Airlines />} />
        </Routes>
      </header>
    </div>
  );
}

export default App;
