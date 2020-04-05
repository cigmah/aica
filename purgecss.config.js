module.exports = {
    defaultExtractor: content => content.match(/[\w-/:]+(?<!:)/g) || [],
    whitelist: ['html', 'table', 'th', 'td', 'ol', 'ul', 'h1', 'h2', 'h3', 'hr', 'p']
}