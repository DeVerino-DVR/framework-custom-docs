import { defineConfig } from 'vitepress'

export default defineConfig({
  title: 'DVRCore',
  description: 'Documentation du framework DVRCore',
  base: '/framework-custom-docs/',

  themeConfig: {
    nav: [
      { text: 'Accueil', link: '/' },
      { text: 'Server', link: '/server' },
      { text: 'Client', link: '/client' },
      { text: 'Menu', link: '/menu' },
    ],

    sidebar: [
      {
        text: 'Introduction',
        items: [
          { text: 'Accueil', link: '/' },
          { text: 'Base de donnees', link: '/database' },
        ]
      },
      {
        text: 'API Server',
        items: [
          { text: 'Player & Core', link: '/server' },
          { text: 'Economie & Taxes', link: '/economy' },
          { text: 'Evenements', link: '/events' },
          { text: 'Inventaire', link: '/inventory' },
        ]
      },
      {
        text: 'API Client',
        items: [
          { text: 'Callbacks, State, KVP', link: '/client' },
          { text: 'Menu', link: '/menu' },
          { text: 'Inventaire', link: '/inventory' },
          { text: 'Skin & Personnalisation', link: '/skin' },
          { text: 'Camera', link: '/camera' },
          { text: 'Prompts', link: '/prompts' },
          { text: 'Personnage', link: '/character' },
          { text: 'KeyMapper', link: '/keymapper' },
        ]
      },
    ],

    socialLinks: [
      { icon: 'github', link: 'https://github.com/DeVerino-DVR/framework-custom' }
    ],

    search: {
      provider: 'local'
    },

    footer: {
      message: 'DVRCore Framework',
    }
  }
})
