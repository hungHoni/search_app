final Map<String, List<Map<String, String>>> phase3FrontendDesignContent = {
  'virtual dom': [
    {
      'title': 'The UI Sync Engine',
      'summary': 'The Virtual DOM is an in-memory representation of the real DOM. Frameworks like React use it to calculate the minimal set of changes needed to update the UI, avoiding expensive browser reflows.',
    },
    {
      'title': 'The Diffing Algorithm',
      'summary': 'When state changes, a new Virtual DOM tree is created. The framework compares it with the previous snapshot (diffing) to find exactly which elements need to be added, removed, or updated.',
    },
    {
      'title': 'Reconciliation Process',
      'summary': 'This is the act of syncing the Virtual DOM with the real browser DOM. By batching these updates, frameworks can provide a smooth 60fps experience even with complex data changes.',
    },
    {
      'title': 'Keys and Performance',
      'summary': 'Just like in Flutter, keys tell the diffing algorithm that an element hasn’t changed even if it moved position, preventing unnecessary re-mounts and preserving component state.',
    },
    {
      'title': 'Server-Side Rendering (SSR)',
      'summary': 'By rendering the initial Virtual DOM to a string on the server, apps can provide faster "First Contentful Paint" and better SEO before the client-side JavaScript takes over.',
    },
  ],
  'design systems': [
    {
      'title': 'The Single Source of Truth',
      'summary': 'A design system is a collection of reusable components and standards (Design Tokens). It ensures visual consistency across multiple platforms and speeds up the handover between designers and engineers.',
    },
    {
      'title': 'Atomic Design',
      'summary': 'A methodology for building UI from the bottom up: Atoms (buttons/inputs), Molecules (search bars), Organisms (headers), Templates (layouts), and Pages.',
    },
    {
      'title': 'Design Tokens',
      'summary': 'Tokens are platform-agnostic variables for colors, spacing, and typography (e.g., `primary-color: #000000`). They allow a brand to update its look across Web, iOS, and Android simultaneously.',
    },
    {
      'title': 'Style Guides vs Systems',
      'summary': 'While style guides are static documentation, a Design System includes the actual coded components in a library (like Storybook) that are used directly in production code.',
    },
    {
      'title': 'Accessibility (a11y)',
      'summary': 'A mature design system builds accessibility into its core components (proper contrast, ARIA labels, focus states), ensuring the app is usable for everyone by default.',
    },
  ],
};
