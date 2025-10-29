import markdown
from django import template
from django.utils.safestring import mark_safe

register = template.Library()

@register.filter(name='markdown')
def markdown_filter(text):
    md = markdown.Markdown(extensions=['extra', 'codehilite'])
    return mark_safe(md.convert(text))

