import markdown
from django import template
from django.utils.safestring import mark_safe

register = template.Library()

@register.filter(name='markdown')
def markdown_filter(text):
    md = markdown.Markdown(extensions=['extra', 'codehilite'])
    return mark_safe(md.convert(text))


@register.filter(name='is_teacher')
def is_teacher_filter(user):
    try:
        if not getattr(user, 'is_authenticated', False) or not hasattr(user, 'profile'):
            return False
        raw_role = (user.profile.role or '').strip()
        role_norm = raw_role.lower()
        # Be tolerant to wrongly saved localized labels
        if role_norm in {'teacher', 'преподаватель'}:
            return True
        # Also check display just in case the raw value is localized
        display = (user.profile.get_role_display() or '').strip().lower()
        return display in {'преподаватель', 'teacher'}
    except Exception:
        return False