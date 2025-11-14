#!/usr/bin/env python3
"""
Create a temporary app icon for building
"""

import os
from PIL import Image, ImageDraw, ImageFont
import sys

def create_app_icon():
    # Create a simple icon with gradient and text
    size = 1024
    img = Image.new('RGB', (size, size), color='white')
    draw = ImageDraw.Draw(img)
    
    # Create gradient background
    for y in range(size):
        r = int(0 + (y / size) * 50)  # Dark cyan to teal gradient
        g = int(150 + (y / size) * 50)
        b = int(150 + (y / size) * 50)
        draw.line([(0, y), (size, y)], fill=(r, g, b))
    
    # Add "AI" text
    try:
        # Try to use a system font, fallback to default if not available
        font_size = int(size * 0.4)
        font = ImageFont.truetype("arial.ttf", font_size)
    except:
        # Use default font if system font not found
        font = ImageFont.load_default()
        
    # Draw AI text
    text = "AI"
    # Get text bounding box
    bbox = draw.textbbox((0, 0), text, font=font)
    text_width = bbox[2] - bbox[0]
    text_height = bbox[3] - bbox[1]
    
    # Center the text
    x = (size - text_width) // 2
    y = (size - text_height) // 2 - 50
    
    # Draw text with shadow
    draw.text((x+5, y+5), text, font=font, fill=(0, 0, 0, 128))  # Shadow
    draw.text((x, y), text, font=font, fill='white')  # Main text
    
    # Draw chat bubble at bottom
    bubble_size = int(size * 0.15)
    bubble_y = int(size * 0.65)
    draw.ellipse([size//2 - bubble_size, bubble_y, 
                  size//2 + bubble_size, bubble_y + bubble_size*2], 
                 fill='white', outline='white', width=5)
    
    # Save the icon
    output_path = os.path.join("SupportChat", "SupportChat", "Assets.xcassets", 
                               "AppIcon.appiconset", "AppIcon.png")
    os.makedirs(os.path.dirname(output_path), exist_ok=True)
    img.save(output_path, "PNG")
    print(f"Icon created: {output_path}")

# Check if Pillow is installed
try:
    from PIL import Image, ImageDraw, ImageFont
    create_app_icon()
except ImportError:
    print("Pillow not installed. Creating a placeholder icon...")
    # Create a minimal PNG file as placeholder
    import struct
    import zlib
    
    # Minimal 1x1 cyan PNG
    png_data = b'\x89PNG\r\n\x1a\n' + \
               b'\x00\x00\x00\rIHDR\x00\x00\x00\x01\x00\x00\x00\x01\x08\x02\x00\x00\x00\x90wS\xde' + \
               b'\x00\x00\x00\x0cIDATx\x9cc\x00\x81\x00\x00\x00\x05\x00\x01\x0d\n-\xb4' + \
               b'\x00\x00\x00\x00IEND\xaeB`\x82'
    
    output_path = os.path.join("SupportChat", "SupportChat", "Assets.xcassets", 
                               "AppIcon.appiconset", "AppIcon.png")
    os.makedirs(os.path.dirname(output_path), exist_ok=True)
    
    with open(output_path, 'wb') as f:
        f.write(png_data)
    print(f"Placeholder icon created: {output_path}")
